--these are the commands that hibernate executes
--this file is required for manual install 
--it should be kept manually updated
create sequence hibernate_sequence start with 1 increment by 1
create table APP_GRID (ID bigint generated by default as identity, DESCRIPTION varchar(255), ENTITY varchar(255) not null, primary key (ID))
create table APP_GRID_COLUMN (ID bigint generated by default as identity, COL_DEF varchar(255), DESCRIPTION varchar(255), ORDERING integer, READ_ONLY integer not null, GRID_ID bigint not null, primary key (ID))
create table APP_MENU (ID bigint generated by default as identity, DESCRIPTION varchar(255), ICON varchar(255), ORDERING integer, PARENT_MENU_ID bigint, primary key (ID))
create table APP_MENU_PAGES (MENU_ID bigint not null, PAGE_ID bigint not null)
create table APP_MENU_ROLES (MENU_ID bigint not null, ROLE_ID bigint not null, primary key (MENU_ID, ROLE_ID))
create table APP_PAGE (ID bigint generated by default as identity, DESCRIPTION varchar(255), icon varchar(255), ORDERING integer, URL varchar(255) not null, primary key (ID))
create table APP_PAGE_ROLES (PAGE_ID bigint not null, ROLE_ID bigint not null, primary key (PAGE_ID, ROLE_ID))
create table APP_ROLE (ID bigint generated by default as identity, DESCRIPTION varchar(255), ROLE_NAME varchar(255) not null, primary key (ID))
create table APP_SETTINGS (ID bigint generated by default as identity, SETUP_DATE timestamp, primary key (ID))
create table APP_USER (ID bigint generated by default as identity, ACTIVE integer not null, BIRTHDATE date, EMAIL varchar(255), PASSWD varchar(255), USERNAME varchar(255) not null, PWD_RECOVERY_CODE varchar(255), NAME varchar(255), SURNAME varchar(255), primary key (ID))
create table APP_USER_ROLE (ROLE_NAME varchar(255) not null, USERNAME varchar(255) not null, primary key (ROLE_NAME, USERNAME))
create table EXAMPLE_FOO (ID bigint not null, description varchar(255), ADDRESS varchar(500), AGE double, BIRTHDAY date, HEIGHT integer, NAME varchar(50), primary key (ID))
create table EXAMPLE_FOO_EXAMPLE_FOO (Foo_ID bigint not null, foos_ID bigint not null)
alter table APP_PAGE add constraint UK_g46ggqwlkw2324y5s2hqcnkci unique (URL)
alter table APP_ROLE add constraint UK_2n9idmawdtvyr87ystwqxfbo2 unique (ROLE_NAME)
create unique index idx_user_username on APP_USER (USERNAME)
create unique index idx_user_userpwd on APP_USER (USERNAME, PASSWD)
create unique index UK_1rkjaykh10esyfffeqqwfayv1 on APP_USER (EMAIL)
alter table EXAMPLE_FOO_EXAMPLE_FOO add constraint UK_ffuqy3auq4ac1jey9csjxloft unique (foos_ID)
alter table APP_GRID_COLUMN add constraint FK25i8s8cn1euf7g90b1ablenob foreign key (GRID_ID) references APP_GRID
alter table APP_MENU add constraint FKjml7045ebsh2emniajuefajfh foreign key (PARENT_MENU_ID) references APP_MENU
alter table APP_MENU_PAGES add constraint FK51mm2sfgwuas1rt4krfx1qgut foreign key (PAGE_ID) references APP_PAGE
alter table APP_MENU_PAGES add constraint FK6wloh5r0x1stcofqidk8li2ul foreign key (MENU_ID) references APP_MENU
alter table APP_MENU_ROLES add constraint FKqbsnq6wlqhtrjl9bqop87oe23 foreign key (ROLE_ID) references APP_ROLE
alter table APP_MENU_ROLES add constraint FKps7jfjk1kewlm8kyeubebq8vu foreign key (MENU_ID) references APP_MENU
alter table APP_PAGE_ROLES add constraint FK3yvof1xdshl5l67lqdlt88ry7 foreign key (ROLE_ID) references APP_ROLE
alter table APP_PAGE_ROLES add constraint FKg8vm7rnxjho1wjmax5igngktc foreign key (PAGE_ID) references APP_PAGE
alter table EXAMPLE_FOO_EXAMPLE_FOO add constraint FK8t08whjmk7ecg5pg9q16v3ggn foreign key (foos_ID) references EXAMPLE_FOO
alter table EXAMPLE_FOO_EXAMPLE_FOO add constraint FKsem345a9vnyr36esfyiqbq75y foreign key (Foo_ID) references EXAMPLE_FOO
