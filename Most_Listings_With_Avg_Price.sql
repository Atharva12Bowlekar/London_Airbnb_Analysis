use datascience_db;

with t1 as
	(select id, listing_url, name, host_id, host_url, host_name,
	cast(SUBSTRING(REPLACE(price, ',', ''), 2, CHAR_LENGTH(price) - 4) as unsigned) as clean_price
	from listings)
    select host_id, host_url, host_name, count(*) as count_of_listings, avg(clean_price) as avg_price
    from t1
    group by host_id, host_url, host_name
    having count_of_listings > 10
    order by count_of_listings desc
    Limit 10;