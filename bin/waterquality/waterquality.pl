use strict;
use warnings;

use Data::Dumper;
use JSON;
use WWW::Mechanize;
use Try::Tiny;
use Term::ANSIColor;

our $json_obj = {};

my $mech = WWW::Mechanize->new();


#my $url = 'http://www.waterqualitydata.us/portal.jsp';

##CSV
#my $url = 'http://www.waterqualitydata.us/Station/search?countrycode=US&statecode=US%3A06&countycode=US%3A06%3A001&mimeType=csv&zip=no';
#$url = 'http://www.waterqualitydata.us/Result/search?countrycode=US&statecode=US%3A06&countycode=US%3A06%3A001&mimeType=csv&zip=no';
#my $csv = $mech->get( $url );

my $xml_url = 'http://waterdata.usgs.gov/nwis/dv?referred_module=sw&site_tp_cd=OC&site_tp_cd=OC-CO&site_tp_cd=ES&site_tp_cd=LK&site_tp_cd=ST&site_tp_cd=ST-CA&site_tp_cd=ST-DCH&site_tp_cd=ST-TS&index_pmcode_30208=1&index_pmcode_00060=1&index_pmcode_72137=1&index_pmcode_50042=1&index_pmcode_99060=1&index_pmcode_61055=1&index_pmcode_00930=1&index_pmcode_81203=1&index_pmcode_00010=1&index_pmcode_00011=1&index_pmcode_00020=1&index_pmcode_00021=1&index_pmcode_45587=1&group_key=NONE&format=sitefile_output&sitefile_output_format=xml&column_name=agency_cd&column_name=site_no&column_name=station_nm&range_selection=days&period=365&begin_date=2014-04-04&end_date=2015-04-03&date_format=YYYY-MM-DD&rdb_compression=file&list_of_search_criteria=site_tp_cd%2Crealtime_parameter_selection';

#my $xml = $mech->get( $xml_url );

sub GetSiteIdsXML($)
{
    my ($file) = @_;

    my $fh;

    open $fh, "<", $file;

    while(my $line = <$fh>)
    {
        if(eof)
        {
            last;
        }

        try {
            
            my @ln = $line =~ m/(<site_no>)([0-9]*)(<\/site_no>)/;
            
            if(defined $ln[1])
            {
                
                my $site_id = "USGS-$ln[1]";
                GetDataBySiteId($site_id);
            
            }

        } catch {

            print "NEEEEXT\n";
            next;

        }; 
    }

    close $fh;

}


sub GetSiteIdsJSON($)
{
    my ($file) = @_;

    my $obj;
    my $fh;

    open $fh, "<", $file or die $!;
    
    while(my $line = <$fh>)
    {
        $obj = from_json($line);
        
        if(eof)
        {
            last;
        }
    }

    close $fh;
    
    my @keys = keys %$obj;

    for(my $i = 0; $i < @keys; $i++)
    { 
        try
        {
            my $site_id = "USGS-$keys[$i]";
            GetDataBySiteId($site_id);
        
            print color "green";
            print "$site_id - Downloaded \n";
            print color "reset";
            
            if($i % 100 == 0)
            {
                WriteInJSONFile("data.json");
            }
        }
        catch
        {
            print color "red";
            print $_;
            print color "reset";
            
            WriteInJSONFile("data.json"); 

            next;
        }
    }

}


sub GetDataBySiteId($)
{
    my ($site_id) = @_;
    
    my $url = 'http://www.waterqualitydata.us/Result/search?countrycode=US&statecode=US%3A06&countycode=US%3A06%3A001&mimeType=csv&zip=no&siteid='.$site_id;
    my $csv = $mech->get( $url ) or die "$site_id - FAILED, $!";
    $csv = $$csv{_content};
    
    my @lines = split("\n", $csv, -1); 
    
    my @keys_arr = split(",", $lines[0], -1);

    if(@keys_arr > 1)
    {

        if(!defined $$json_obj{ $site_id })
        {
            $$json_obj{ $site_id } = [];
        }

        for(my $i = 1; $i < @lines; $i++)
        {
            my @content = split(",", $lines[$i], -1);
            my $line_obj = {};

            for(my $k = 0; $k < @content; $k++)
            {
                if(!$keys_arr[$k])
                {
                    next;
                }

                $$line_obj{ $keys_arr[$k] } = $content[$k];
            }

            push @{ $$json_obj{ $site_id } }, $line_obj;
        }

    }
=comment
    my $fh2;
    open $fh2, ">", "csv/${site_id}.csv" or die "$site_id - FAILED, $!";
    print $fh2 $csv;
    close $fh2 or die "$site_id - FAILED, $!";
=cut

    return 1;
}

sub WriteInJSONFile($)
{
    my ($file_name) = @_;
    
    my $json = to_json($json_obj);

    my $fh2;
    open $fh2, ">", $file_name or die $!;
    print $fh2 $json;
    close $fh2 or die $!;
    
    print "FLUSH \n";
}

#GetSiteIdsXML("sites.xml");
GetSiteIdsJSON("../usgs-sites-current-info.json");

WriteInJSONFile("data.json");

