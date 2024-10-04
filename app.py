from flask import Flask, render_template, request, redirect, flash, url_for, session
import mysql.connector
from functools import wraps
from time import sleep

app = Flask(__name__)
app.secret_key = 'sua_chave_secreta'

db_config = {'host': 'localhost','user': 'root', 'password': 'Pipoca.26','database': 'aipo'}

@app.route('/')
def form():
    
    return render_template('inicial.html')

@app.route('/cadastrar_usuario', methods=['GET', 'POST'])
def cadastrar_usuario():
    perfilid = session.get('perfilid')
    if perfilid == 1:
        session.clear() 
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Coleta de perfis para o menu suspenso
        cursor.execute("SELECT id, nome FROM perfil")
        perfis = cursor.fetchall()
        
        if request.method == 'POST':
            matricula = request.form['matricula']
            nome = request.form['nome'].title()
            senha = request.form['senha']
            email = request.form['email'].lower()
            codigo = request.form['codigo'].replace(' ', '')
            idPerfil = request.form['idPerfil']

            try:
                query = """
                INSERT INTO usuario (matricula, nome, senha, email, codigo, idPerfil)
                VALUES (%s, %s, %s, %s, %s, %s)
                """
                cursor.execute(query, (matricula, nome, senha, email, codigo, idPerfil))
                conn.commit()
                flash('Usuário cadastrado com sucesso!', 'success')

            except mysql.connector.Error as err:
                if err.errno == 1045:
                    flash('Erro de acesso: Verifique suas credenciais.', 'danger')
                elif err.errno == 1064:
                    flash('Erro de sintaxe: Verifique sua consulta SQL.', 'danger')
                elif err.errno == 1062:
                    flash('Erro: O usuário já existe.', 'danger')
                elif err.errno == 1264:
                    flash('Erro: Valor fora do intervalo para um dos campos.', 'danger')
                elif err.errno == 1406:
                    flash('Erro: Um dos valores é muito longo.', 'danger')
                elif err.errno == 1452:
                    flash('Erro: Violação de chave estrangeira.', 'danger')
                elif err.errno == 1054:
                    flash('Erro: Coluna desconhecida na consulta.', 'danger')
                elif err.errno == 1146:
                    flash('Erro: Tabela desconhecida no banco de dados.', 'danger')
                else:
                    flash(f'Erro: {err}', 'danger')

            
            finally:
                cursor.close()
                conn.close()

            return redirect('/cadastrar_usuario')

        return render_template('usuario.html', perfis=perfis)
    else:
        flash('Você precisa estar logado para acessar esta página.', 'danger')
        return redirect(url_for('login_usuario'))

@app.route('/login', methods=['GET', 'POST'])
def login_usuario():

    if request.method == 'POST':
        senha = request.form['senha']
        email = request.form['email'].lower()

        try:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor(dictionary=True)
            
            query = "SELECT * FROM usuario WHERE email = %s"
            cursor.execute(query, (email,))
            user = cursor.fetchone()
          
            if user:
                if user['senha'] == senha:
                    if user['idPerfil'] == 1:
                        flash('Login como administrador bem-sucedido!', 'success')
                        session['perfilid'] = user['idPerfil']
                        return redirect(url_for('cadastrar_usuario'))
                    else:
                        flash('Acesso negado: você não é um administrador.', 'danger')
                else:
                    flash('Senha incorreta.', 'danger')
            else:
                flash('Usuário não encontrado.', 'danger')

        except mysql.connector.Error as err:
            if err.errno == 1045:
                flash('Erro de acesso: Verifique suas credenciais.', 'danger')
            elif err.errno == 1064:
                flash('Erro de sintaxe: Verifique sua consulta SQL.', 'danger')
            elif err.errno == 1062:
                flash('Erro: O usuário já existe.', 'danger')
            elif err.errno == 1264:
                flash('Erro: Valor fora do intervalo para um dos campos.', 'danger')
            elif err.errno == 1406:
                flash('Erro: Um dos valores é muito longo.', 'danger')
            elif err.errno == 1452:
                flash('Erro: Violação de chave estrangeira.', 'danger')
            elif err.errno == 1054:
                flash('Erro: Coluna desconhecida na consulta.', 'danger')
            elif err.errno == 1146:
                flash('Erro: Tabela desconhecida no banco de dados.', 'danger')
            else:
                flash(f'Erro: {err}', 'danger')

        finally:
            cursor.close()
            conn.close()
        return redirect('/login')
    
    return render_template('login.html')