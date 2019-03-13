FROM sqljudge/workwer

WORKDIR /app

COPY ./setup.sql ./
RUN sqlite3 test.db < setup.sql

CMD ["ruby", "app.rb"]
