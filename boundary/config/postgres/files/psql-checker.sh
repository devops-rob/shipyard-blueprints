until pg_isready -h localhost -p 5432 -U postgres
do
  echo "Waiting for postgres at: localhost:5432"
  sleep 2;
done