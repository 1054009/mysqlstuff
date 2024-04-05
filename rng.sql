drop function if exists rng;
delimiter //
create function rng(`min` int, `max` int) returns int deterministic
begin
	return floor(rand() * (`max` - `min` + 1) + `min`);
end//
delimiter ;
