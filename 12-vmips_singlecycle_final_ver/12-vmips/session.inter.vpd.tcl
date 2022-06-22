# Begin_DVE_Session_Save_Info
# DVE view(Wave.2 ) session
# Saved on Tue Jun 7 13:26:34 2022
# Toplevel windows open: 1
# 	TopLevel.1
#   Wave.2: 13 signals
# End_DVE_Session_Save_Info

# DVE version: R-2020.12-SP1_Full64
# DVE build date: Mar  2 2021 21:35:25


#<Session mode="View" path="/home/KNUEEhdd1/elec518/tjp6/01-vcs/12-vmips/session.inter.vpd.tcl" type="Debug">

#<Database>

gui_set_time_units 1ps
#</Database>

# DVE View/pane content session: 

# Begin_DVE_Session_Save_Info (Wave.2)
# DVE wave signals session
# Saved on Tue Jun 7 13:26:34 2022
# 13 signals
# End_DVE_Session_Save_Info

# DVE version: R-2020.12-SP1_Full64
# DVE build date: Mar  2 2021 21:35:25


#Add ncecessay scopes
gui_load_child_values {vmips_tb}

gui_set_time_units 1ps

set _wave_session_group_2 vmips_tb
if {[gui_sg_is_group -name "$_wave_session_group_2"]} {
    set _wave_session_group_2 [gui_sg_generate_new_name]
}
set Group1 "$_wave_session_group_2"

gui_sg_addsignal -group "$_wave_session_group_2" { {Sim:vmips_tb.sPC} {Sim:vmips_tb.PC} {Sim:vmips_tb.inst} {Sim:vmips_tb.clk} {Sim:vmips_tb.rst} {Sim:vmips_tb.u0.result_x} {Sim:vmips_tb.u0.result_y} {Sim:vmips_tb.u0.result_z} {Sim:vmips_tb.u0.result_w} {Sim:vmips_tb.u0.wdat_x} {Sim:vmips_tb.u0.wdat_y} {Sim:vmips_tb.u0.wdat_z} {Sim:vmips_tb.u0.wdat_w} }
if {![info exists useOldWindow]} { 
	set useOldWindow true
}
if {$useOldWindow && [string first "Wave" [gui_get_current_window -view]]==0} { 
	set Wave.2 [gui_get_current_window -view] 
} else {
	set Wave.2 [lindex [gui_get_window_ids -type Wave] 0]
if {[string first "Wave" ${Wave.2}]!=0} {
gui_open_window Wave
set Wave.2 [ gui_get_current_window -view ]
}
}

set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.2}  C1
gui_wv_zoom_timerange -id ${Wave.2} 0 310000
gui_list_add_group -id ${Wave.2} -after {New Group} [list ${Group1}]
gui_list_select -id ${Wave.2} {vmips_tb.u0.wdat_x }
gui_seek_criteria -id ${Wave.2} {Any Edge}


gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.2} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.2} -text {*}
gui_list_set_insertion_bar  -id ${Wave.2} -group ${Group1}  -item {vmips_tb.u0.result_w[31:0]} -position below

gui_marker_move -id ${Wave.2} {C1} 310000
gui_view_scroll -id ${Wave.2} -vertical -set 95
gui_show_grid -id ${Wave.2} -enable false
#</Session>

