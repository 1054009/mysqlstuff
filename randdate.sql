-- Requires rng.sql

drop function if exists concatdate;
drop function if exists randdate;
delimiter //
create function concatdate(`year` int, `month` int, `day` int) returns date deterministic
begin
	declare `fixed_month` varchar(255) default '00';
	declare `fixed_day` varchar(255) default '00';

	select convert(`month`, char) into `fixed_month`;
	select convert(`day`, char) into `fixed_day`;

	if `month` < 10 then
		set `fixed_month` = concat('0', `fixed_month`);
	end if;

	if `day` < 10 then
		set `fixed_day` = concat('0', `fixed_day`);
	end if;

	return str_to_date(concat(`fixed_day`, ',', `fixed_month`, ',', `year`), '%d,%m,%Y');
end//

create function randdate() returns date deterministic
begin
	declare `current_year` int default 0;
	declare `current_month` int default 0;
	declare `current_day` int default 0;

	set `current_year` = rng(1900, year(curdate()));
	set `current_month` = rng(1, 12);
	set `current_day` = rng(1, day(last_day(concatdate(`current_year`, `current_month`, 1))));

	return concatdate(`current_year`, `current_month`, `current_day`);
end//
delimiter ;
