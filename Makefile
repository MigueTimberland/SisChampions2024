docker-test: 
	docker-compose run web php artisan test

test: 
	php artisan test