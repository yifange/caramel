User.delete_all
User.create(email: 'deng.jinqiu@gmail.com', password: '123456', password_confirmation: '123456', first_name: 'Jinqiu', middle_name: nil, last_name: 'Deng', type: 'Admin', remember_me_token: nil, remember_me_token_expires_at: nil)
User.create(email: 'shen.dongye@gmail.com', password: '123456', password_confirmation: '123456', first_name: 'Dongye', middle_name: nil, last_name: 'Shen', type: 'Teacher', remember_me_token: nil, remember_me_token_expires_at: nil)
User.create(email: 'ge.yifan@gmail.com', password: '123456', password_confirmation: '123456', first_name: 'Yifan', middle_name: nil, last_name: 'Ge', type: 'Admin', remember_me_token: nil, remember_me_token_expires_at: nil)
User.create(email: 'chu.shuya@gmail.com', password: '123456', password_confirmation: '123456', first_name: 'Shuya', middle_name: nil, last_name: 'Chu', type: 'Admin', remember_me_token: nil, remember_me_token_expires_at: nil)

Program.delete_all
Program.create(1, 1, 1, 1, 1)

Instrument.delete_all
Instrument.create('piano')

Course_type.delete_all
Course_type.create('POD', 'pad program')

School.delete_all
School.create(1, 'JHU', 'Johns Hopkins University')

Student.delete_all

Region.delete_all
Region.create('DC')
