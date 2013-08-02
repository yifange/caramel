Instrument.delete_all
Instrument.create(name: 'piano')
Instrument.create(name: 'guitar')
Instrument.create(name: 'violin')

CourseType.delete_all
CourseType.create(abbrev: 'IND', full: 'individual')
CourseType.create(abbrev: 'POD', full: 'pod program')

Region.delete_all
@r_wdc  = Region.create(name: 'Washington DC')
@r_bal  = Region.create(name: 'Baltimore')
@r_chgo = Region.create(name: 'Chicago')


User.delete_all
@u_deng  = User.create(email: 'deng.jinqiu@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Jinqiu', middle_name: nil, last_name: 'Deng', type: 'Admin', remember_me_token: nil, remember_me_token_expires_at: nil)
@u_shen  = User.create(email: 'shen.dongye@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Dongye', middle_name: 'D', last_name: 'Shen', type: 'Staff', remember_me_token: nil, remember_me_token_expires_at: nil)
@u_lu    = User.create(email: 'lu.fenghuan@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Fenghuan', middle_name: 'J', last_name: 'Lu', type: 'Staff', remember_me_token: nil, remember_me_token_expires_at: nil)
@u_huang = User.create(email: 'huang.yunchi@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Yunchi', middle_name: 'K', last_name: 'Huang', type: 'Staff', remember_me_token: nil, remember_me_token_expires_at: nil)
@u_ge    = User.create(email: 'ge.yifan@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Yifan', middle_name: nil, last_name: 'Ge', type: 'Teacher', remember_me_token: nil, remember_me_token_expires_at: nil)
@u_chu   = User.create(email: 'chu.shuya@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Shuya', middle_name: nil, last_name: 'Chu', type: 'Teacher', remember_me_token: nil, remember_me_token_expires_at: nil)
@u_yue   = User.create(email: 'yue.mengchao@gmail.com', password: '123456', password_confirmation: '123456', 
                       first_name: 'Mengchao', middle_name: nil, last_name: 'Yue', type: 'Teacher', remember_me_token: nil, remember_me_token_expires_at: nil)

Domain.create(user_id: @u_shen.id, region_id: @r_wdc.id)
Domain.create(user_id: @u_lu.id, region_id: @r_wdc.id)
Domain.create(user_id: @u_huang.id, region_id: @r_wdc.id)
Domain.create(user_id: @u_ge.id, region_id: @r_wdc.id)
Domain.create(user_id: @u_chu.id, region_id: @r_wdc.id)

School.delete_all
@s_jhu = School.create(abbrev: 'JHU', full: 'Johns Hopkins University', region_id: @r_bal.id)
@s_ub  = School.create(abbrev: 'UB', full: 'University of Baltimore', region_id: @r_bal.id)
@s_gwu = School.create(abbrev: 'GWU', full: 'George Washington University', region_id: @r_wdc.id)
@s_gtu = School.create(abbrev: 'GTU', full: 'George Town University', region_id: @r_wdc.id)
@s_uc  = School.create(abbrev: 'UC', full: 'University of Chicago', region_id: @r_chgo.id)
@s_uic = School.create(abbrev: 'UIC', full: 'University of Illinois at Chicago', region_id: @r_chgo.id)

Program.delete_all
@p_1 = Program.create(school_id: @s_jhu.id,
               instrument_id: Instrument.where(name: 'piano').first.id,
               course_type_id: CourseType.where(full: 'individual').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 40)
@p_2 = Program.create(school_id: @s_jhu.id,
               instrument_id: Instrument.where(name: 'guitar').first.id,
               course_type_id: CourseType.where(full: 'individual').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 30)
@p_3 = Program.create(school_id: @s_ub.id,
               instrument_id: Instrument.where(name: 'guitar').first.id,
               course_type_id: CourseType.where(full: 'individual').first.id,
               regular_courses_per_year: 120,
               group_courses_per_year: 50)
@p_4 = Program.create(school_id: @s_ub.id,
               instrument_id: Instrument.where(name: 'violin').first.id,
               course_type_id: CourseType.where(full: 'individual').first.id,
               regular_courses_per_year: 100,
               group_courses_per_year: 50)

Assignment.create(program_id: @p_1.id, teacher_id: @u_ge.id)
Assignment.create(program_id: @p_2.id, teacher_id: @u_ge.id)
# Program.create(3, 2, 1, 120, 50)
# Program.create(4, 1, 1, 120, 40)
# 
# 
# Student.delete_all
# 
