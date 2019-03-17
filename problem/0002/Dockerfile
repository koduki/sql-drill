FROM sqljudge/workwer

WORKDIR /app

COPY ./setup.sql ./
RUN sqlite3 test.db < setup.sql

CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "8080"]
