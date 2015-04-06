use strict;

use WWW::Mechanize;
use XML::XML2JSON;
use XML::Simple;
use JSON;
use Data::Dumper;

my $mech = WWW::Mechanize->new();


my $url = "http://waterdata.usgs.gov/nwis/dv?referred_module=sw&site_tp_cd=AT&site_tp_cd=GL&site_tp_cd=OC&site_tp_cd=OC-CO&site_tp_cd=ES&site_tp_cd=LK&site_tp_cd=ST&site_tp_cd=ST-CA&site_tp_cd=ST-DCH&site_tp_cd=ST-TS&site_tp_cd=SP&site_tp_cd=GW&site_tp_cd=GW-CR&site_tp_cd=GW-EX&site_tp_cd=GW-HZ&site_tp_cd=GW-IW&site_tp_cd=GW-MW&site_tp_cd=GW-TH&site_tp_cd=SB&site_tp_cd=SB-CV&site_tp_cd=SB-GWD&site_tp_cd=SB-TSM&site_tp_cd=SB-UZ&site_tp_cd=WE&site_tp_cd=LA&site_tp_cd=LA-EX&site_tp_cd=LA-OU&site_tp_cd=LA-SNK&site_tp_cd=LA-SH&site_tp_cd=LA-SR&site_tp_cd=FA&site_tp_cd=FA-CI&site_tp_cd=FA-CS&site_tp_cd=FA-DV&site_tp_cd=FA-FON&site_tp_cd=FA-GC&site_tp_cd=FA-HP&site_tp_cd=FA-QC&site_tp_cd=FA-LF&site_tp_cd=FA-OF&site_tp_cd=FA-PV&site_tp_cd=FA-SPS&site_tp_cd=FA-STS&site_tp_cd=FA-TEP&site_tp_cd=FA-WIW&site_tp_cd=FA-SEW&site_tp_cd=FA-WWD&site_tp_cd=FA-WWTP&site_tp_cd=FA-WDS&site_tp_cd=FA-WTP&site_tp_cd=FA-WU&site_tp_cd=AW&site_tp_cd=AG&site_tp_cd=AS&group_key=NONE&sitefile_output_format=html_table&column_name=agency_cd&column_name=site_no&column_name=station_nm&range_selection=days&period=365&begin_date=2014-04-01&end_date=2015-03-31&set_arithscale_y=on&format=html_table&date_format=YYYY-MM-DD&rdb_compression=value&list_of_search_criteria=site_tp_cd%2Crealtime_parameter_selection";

my $url1 = "http://waterdata.usgs.gov/nwis/dvstat?referred_module=sw&site_tp_cd=AT&site_tp_cd=GL&site_tp_cd=OC&site_tp_cd=OC-CO&site_tp_cd=ES&site_tp_cd=LK&site_tp_cd=ST&site_tp_cd=ST-CA&site_tp_cd=ST-DCH&site_tp_cd=ST-TS&site_tp_cd=SP&site_tp_cd=GW&site_tp_cd=GW-CR&site_tp_cd=GW-EX&site_tp_cd=GW-HZ&site_tp_cd=GW-IW&site_tp_cd=GW-MW&site_tp_cd=GW-TH&site_tp_cd=SB&site_tp_cd=SB-CV&site_tp_cd=SB-GWD&site_tp_cd=SB-TSM&site_tp_cd=SB-UZ&site_tp_cd=WE&site_tp_cd=LA&site_tp_cd=LA-EX&site_tp_cd=LA-OU&site_tp_cd=LA-SNK&site_tp_cd=LA-SH&site_tp_cd=LA-SR&site_tp_cd=FA&site_tp_cd=FA-CI&site_tp_cd=FA-CS&site_tp_cd=FA-DV&site_tp_cd=FA-FON&site_tp_cd=FA-GC&site_tp_cd=FA-HP&site_tp_cd=FA-QC&site_tp_cd=FA-LF&site_tp_cd=FA-OF&site_tp_cd=FA-PV&site_tp_cd=FA-SPS&site_tp_cd=FA-STS&site_tp_cd=FA-TEP&site_tp_cd=FA-WIW&site_tp_cd=FA-SEW&site_tp_cd=FA-WWD&site_tp_cd=FA-WWTP&site_tp_cd=FA-WDS&site_tp_cd=FA-WTP&site_tp_cd=FA-WU&site_tp_cd=AW&site_tp_cd=AG&site_tp_cd=AS&group_key=NONE&format=sitefile_output&sitefile_output_format=html_table&column_name=agency_cd&column_name=site_no&column_name=station_nm&column_name=site_tp_cd&column_name=lat_va&column_name=long_va&column_name=dec_lat_va&column_name=dec_long_va&column_name=coord_meth_cd&column_name=coord_acy_cd&column_name=coord_datum_cd&column_name=dec_coord_datum_cd&column_name=district_cd&column_name=state_cd&column_name=county_cd&column_name=country_cd&column_name=land_net_ds&column_name=map_nm&column_name=map_scale_fc&column_name=alt_va&column_name=alt_meth_cd&column_name=alt_acy_va&column_name=alt_datum_cd&column_name=huc_cd&column_name=basin_cd&column_name=topo_cd&column_name=data_types_cd&column_name=instruments_cd&column_name=construction_dt&column_name=inventory_dt&column_name=drain_area_va&column_name=contrib_drain_area_va&column_name=tz_cd&column_name=local_time_fg&column_name=reliability_cd&column_name=gw_file_cd&column_name=nat_aqfr_cd&column_name=aqfr_cd&column_name=aqfr_type_cd&column_name=well_depth_va&column_name=hole_depth_va&column_name=depth_src_cd&column_name=project_no&column_name=rt_bol&column_name=peak_begin_date&column_name=peak_end_date&column_name=peak_count_nu&column_name=qw_begin_date&column_name=qw_end_date&column_name=qw_count_nu&column_name=gw_begin_date&column_name=gw_end_date&column_name=gw_count_nu&column_name=sv_begin_date&column_name=sv_end_date&column_name=sv_count_nu&list_of_search_criteria=site_tp_cd%2Crealtime_parameter_selection";

my $url3 = "http://waterdata.usgs.gov/nwis/dv?referred_module=sw&site_tp_cd=OC&site_tp_cd=OC-CO&site_tp_cd=ES&site_tp_cd=LK&site_tp_cd=ST&site_tp_cd=ST-CA&site_tp_cd=ST-DCH&site_tp_cd=ST-TS&index_pmcode_30208=1&index_pmcode_00060=1&index_pmcode_72137=1&index_pmcode_50042=1&index_pmcode_99060=1&index_pmcode_61055=1&index_pmcode_00930=1&index_pmcode_81203=1&index_pmcode_00010=1&index_pmcode_00011=1&index_pmcode_00020=1&index_pmcode_00021=1&index_pmcode_45587=1&group_key=NONE&format=sitefile_output&sitefile_output_format=xml&column_name=agency_cd&column_name=site_no&column_name=station_nm&range_selection=days&period=365&begin_date=2014-04-04&end_date=2015-04-03&date_format=YYYY-MM-DD&rdb_compression=file&list_of_search_criteria=site_tp_cd%2Crealtime_parameter_selection";

my $url4 = "http://waterdata.usgs.gov/nwis/inventory?site_tp_cd=ST&drain_area_va_min=700&drain_area_va_conjunction=and&site_md=1&site_md_minutes=525000&group_key=NONE&format=sitefile_output&sitefile_output_format=xml&column_name=agency_cd&column_name=site_no&column_name=station_nm&column_name=site_tp_cd&column_name=lat_va&column_name=long_va&column_name=dec_lat_va&column_name=dec_long_va&column_name=coord_meth_cd&column_name=coord_acy_cd&column_name=coord_datum_cd&column_name=dec_coord_datum_cd&column_name=district_cd&column_name=state_cd&column_name=county_cd&column_name=country_cd&column_name=land_net_ds&column_name=map_nm&column_name=map_scale_fc&column_name=alt_va&column_name=alt_meth_cd&column_name=alt_acy_va&column_name=alt_datum_cd&column_name=huc_cd&column_name=basin_cd&column_name=topo_cd&column_name=data_types_cd&column_name=instruments_cd&column_name=construction_dt&column_name=inventory_dt&column_name=drain_area_va&column_name=contrib_drain_area_va&column_name=tz_cd&column_name=local_time_fg&column_name=reliability_cd&column_name=gw_file_cd&column_name=nat_aqfr_cd&column_name=aqfr_cd&column_name=aqfr_type_cd&column_name=well_depth_va&column_name=hole_depth_va&column_name=depth_src_cd&column_name=project_no&column_name=rt_bol&column_name=peak_begin_date&column_name=peak_end_date&column_name=peak_count_nu&column_name=qw_begin_date&column_name=qw_end_date&column_name=qw_count_nu&column_name=gw_begin_date&column_name=gw_end_date&column_name=gw_count_nu&column_name=sv_begin_date&column_name=sv_end_date&column_name=sv_count_nu&list_of_search_criteria=site_tp_cd%2Cdrain_area_va%2Csite_md";

my $xml = $mech->get($url4);

#print $xml->content;
my $XML2JSON = XML::XML2JSON->new();
my $JSON = from_json($XML2JSON->convert($xml->content));
my $json_1;

#print Dumper $JSON;
for my $key (@{$$JSON{usgs_nwis}{site}})
{
    for my $key1 (keys $key)
    {
        $$json_1{$$key{site_no}{'$t'}}{$key1} = $$key{$key1}{'$t'};
    }
}
print to_json $json_1;

#{"agency_cd":{"$t":"USGS"},"site_no":{"$t":"772641162391501"},"station_nm":{"$t":"ONYX RIVER AT LOWER WRIGHT WEIR, ANTARCTICA"}}
