FROM koduki/sqljudge-worker

WORKDIR /app

COPY ./setup.sql ./
RUN sqlite3 test.db < setup.sql

CMD ["ruby", "app.rb"]
