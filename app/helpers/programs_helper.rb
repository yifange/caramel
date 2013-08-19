module ProgramsHelper
#   def school_tabs_for(schools)
#     buf = "".html_safe
#     for i in 0...schools.length
#       anchor_content = content_tag :a, schools[i].abbrev, :href => "#tab-#{schools[i].id}", "data-toggle" => "tab", :title => schools[i].full, :class => "tab-hover"
#       if i == 0
#         tab = content_tag :li, anchor_content, :class => "active"
#       else
#         tab = content_tag :li, anchor_content
#       end
#       buf.concat(tab)
#     end
#     buf
#   end
# 
# 
#   def school_tab_panes_for(schools, programs)
#     buf = "".html_safe
#     for i in 0...schools.length
#       buf_tab = "".html_safe
#       buf_table = "".html_safe
#       programs_for_school = programs.where( :school_id => schools[i].id )
# 
#       tab_content = content_tag :table, :class => "table table-striped table-bordered" do
#         content_tag :tbody do
#           buf_program = "".html_safe
#           programs_for_school.each do |program|
#             buf_tr = content_tag :tr do
#               buf_td1 = content_tag :td do
#                 content_tag :a, Instrument.find(program.instrument_id).name, :class => "instrument-options", :href => "#", "data-type" => "select2", "data-pk" => "#{program.id}", "data-url" => "/programs_page/save_instrument", "data-source" => "/programs_page/get_instruments.json", "data-value" => "1", "data-title" => "Select Instrument"
#               end
# 
#               buf_td2 = content_tag :td do
#                 content_tag :a, ProgramType.find(program.program_type_id).name, :class => "course-type-options", :href => "#", "data-type" => "select2", "data-pk" => "#{program.id}", "data-url" => "/programs_page/save_program_type", "data-source" => "/programs_page/get_program_types.json", "data-value" => "1", "data-title" => "Select Course Type"
#               end
# 
#               buf_td3 = content_tag :td do
#                 content_tag :a, program.regular_courses_per_year, :class => "regular-courses-per-year", :href => "#", "data-type" => "text", "data-pk" => "#{program.id}", "data-url" => "/programs_page/save_regular_courses", "data-value" => program.regular_courses_per_year, "data-title" => "Input Regular Courses per Year"
#               end
# 
#               buf_td4 = content_tag :td do
#                 content_tag :a, program.group_courses_per_year, :class => "group-courses-per-year", :href => "#", "data-type" => "text", "data-pk" => "#{program.id}", "data-url" => "/programs_page/save_group_courses", "data-value" => program.group_courses_per_year, "data-title" => "Input Group Courses per Year"
#               end
# 
#               buf_td5 = content_tag :td, "Show Detail", "data-toggle" => "collapse", "data-target" => "#collapse-#{program.id}", :class => "accordin-toggle"
#               buf_td1.concat(buf_td2).concat(buf_td3).concat(buf_td4).concat(buf_td5)
#             end
# 
#             buf_tr_cols = content_tag :tr do
#               content_tag :td, :class => "detailInfo", :colspan => "6" do
#                 content_tag :div, :class => "accodian-body collapse", :id => "collapse-#{program.id}" do
#                   buf_detail = "".html_safe
#                   buf_dt1 = content_tag :span, "Teachers"
# # <<<<<<< HEAD
# #                   buf_dt2 = content_tag :input, nil, :class => "teacher-options",  :value => "#{@assigned_teachers[program.id]}", "data-pk" => "#{program.id}"
# #                   buf_detail.concat(buf_dt1).concat(buf_dt2)
# # =======
#                   buf_dt2 = content_tag :input, nil, :class => "teacher-options", :type => "hidden", :value => "#{@assigned_teachers[program.id]}", "data-pk" => "#{program.id}"
#                   buf_dt3 = content_tag :span, "Students"
#                   buf_dt4 = content_tag :input, nil, :class => "student-options", :type => "hidden", :value => "#{@enrolled_students[program.id]}", "data-pk" => "#{program.id}"
#                   buf_detail.concat(buf_dt1).concat(buf_dt2).concat(buf_dt3).concat(buf_dt4)
# # >>>>>>> origin/latte
#                 end
#               end
#             end
#             buf_program.concat(buf_tr).concat(buf_tr_cols)
#           end # end for program
#           buf_program
#         end # end for tbody
#       end # end for table
#       buf_pane_button = content_tag :a, "New Program", :class => "btn btn-primary new-program", :href => "/programs/new", "data-school" => "#{schools[i].id}"
#       
#       buf_tab.concat(tab_content).concat(buf_pane_button)
# 
#       if i == 0
#         buf_pane = content_tag :div, buf_tab, :class => "tab-pane active", :id => "tab-#{schools[i].id}"
#       else
#         buf_pane = content_tag :div, buf_tab, :class => "tab-pane", :id => "tab-#{schools[i].id}"
#       end
#       buf.concat(buf_pane)
#     end
#     buf
#   end

end
