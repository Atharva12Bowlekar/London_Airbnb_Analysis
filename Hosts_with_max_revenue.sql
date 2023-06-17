use datascience_db;

with t1 as
	(select id, listing_url, name, host_id, host_url, host_name,
	cast(SUBSTRING(REPLACE(price, ',', ''), 2, CHAR_LENGTH(price) - 4) as unsigned) as clean_price,
    cast(SUBSTRING(REPLACE(price, ',', ''), 2, CHAR_LENGTH(price) - 4) as unsigned)*(30 - availability_30) as revenue_projected
	from listings)
    select host_id, host_url, host_name, count(*) as count_of_listings, sum(revenue_projected) as total_revenue
    from t1
    group by host_id, host_url, host_name
    order by total_revenue desc
    Limit 10;
      