from server.routes import *
from server.models import *
from server.webapp import flaskapp, database, cursor, TEMPLATES
import os
import sys
sys.path.append('.')


default_books = [
    ("The Hobbit", "JRR Tolkien", True),
    ("The Fellowship of the Ring", "JRR Tolkien", True),
    ("The Eye of the World", "Robert Jordan", False),
    ("A Game of Thrones", "George R. R. Martin", True),
    ("The Way of Kings", "Brandon Sanderson", False)
]

# Removido token hardcoded - deve ser configurado via variável de ambiente
# env_token = os.environ.get('GITHUB_TOKEN', '')


if __name__ == "__main__":
    cursor.execute(
        '''CREATE TABLE books (name text, author text, read text)'''
    )

    for bookname, bookauthor, hasread in default_books:
        try:
            cursor.execute(
                'INSERT INTO books values (?, ?, ?)',
                (bookname, bookauthor, 'true' if hasread else 'false')
            )

        except Exception as err:
            print(f'[!] Error Occurred: {err}')

    # Corrigido: Usar localhost em vez de 0.0.0.0 para evitar binding para todas as interfaces
    flaskapp.run('127.0.0.1', debug=bool(os.environ.get('DEBUG', False)))

    cursor.close()
    database.close()
