
from flask import request, render_template, make_response

from server.webapp import flaskapp, cursor
from server.models import Book


@flaskapp.route('/')
def index():
    name = request.args.get('name')
    author = request.args.get('author')
    read = bool(request.args.get('read'))

    if name:
        # Corrigido: Usar query parametrizada para prevenir SQL Injection
        cursor.execute(
            "SELECT * FROM books WHERE name LIKE ?",
            (f'%{name}%',)
        )
        books = [Book(*row) for row in cursor]

    elif author:
        # Corrigido: Usar query parametrizada para prevenir SQL Injection
        cursor.execute(
            "SELECT * FROM books WHERE author LIKE ?",
            (f'%{author}%',)
        )
        books = [Book(*row) for row in cursor]

    else:
        cursor.execute("SELECT name, author, read FROM books")
        books = [Book(*row) for row in cursor]

    return render_template('books.html', books=books)
