module ProgramsHelper
  def school_tabs_for(schools)
    buf = "".html_safe
    for i in 0...schools.length
      anchor_content = content_tag :a, schools[i].abbrev, :href => "#tab-#{schools[i].id}", "data-toggle" => "tab"
      if i == 0
        tab = content_tag :li, anchor_content, :class => "active"
      else
        tab = content_tag :li, anchor_content
      end
      buf.concat(tab)
    end
    buf
  end

  def school_tab_panes_for(schools, programs)
    buf = "".html_safe
    for i in 0...schools.length
      buf_tab = "".html_safe
      buf_table = "".html_safe
      programs_for_school = programs.where( :school_id => schools[i].id )

      tab_content = content_tag :table, :class => "table table-stripped table-bordered" do
        content_tag :tbody do
          buf_program = "".html_safe
          programs_for_school.each do |program|
            buf_tr = content_tag :tr do
              buf_td1 = content_tag :td do
                content_tag :a, Instrument.find(program.instrument_id).name, :class => "instrument-options", :href => "#", "data-type" => "select2", "data-pk" => "#{program.id}", "data-url" => "/programs_page/save_instruments", "data-source" => "/programs_page/get_instruments.json", "data-value" => "1", "data-title" => "Select Instrument"
              end

              buf_td2 = content_tag :td, program.course_type.full
              buf_td3 = content_tag :td, program.regular_courses_per_year
              buf_td4 = content_tag :td, program.group_courses_per_year
              buf_td5 = content_tag :td, "Show Detail", "data-toggle" => "collapse", "data-target" => "#collapse-#{program.id}", :class => "accordin-toggle"
              buf_td1.concat(buf_td2).concat(buf_td3).concat(buf_td4).concat(buf_td5)
            end

            buf_tr_cols = content_tag :tr do
              content_tag :td, :class => "detailInfo", :colspan => "6" do
                content_tag :div, :class => "accodian-body collapse", :id => "collapse-#{program.id}" do
                  buf_detail = "".html_safe
                  buf_dt1 = content_tag :span, "Teachers"
                  buf_dt2 = content_tag :input, nil, :class => "teacher-options", :type => "hidden", :value => "#{@assigned_teachers[program.id]}", "data-pk" => "#{program.id}"
                  buf_detail.concat(buf_dt1).concat(buf_dt2)
                end
              end
            end
            buf_program.concat(buf_tr).concat(buf_tr_cols)
          end # end for program
          buf_program
        end # end for tbody
      end # end for table
      buf_tab.concat(tab_content)

      if i == 0
        buf_pane = content_tag :div, buf_tab, :class => "tab-pane active", :id => "tab-#{schools[i].id}"
      else
        buf_pane = content_tag :div, buf_tab, :class => "tab-pane", :id => "tab-#{schools[i].id}"
      end
      buf.concat(buf_pane)
    end
    buf
  end

end
