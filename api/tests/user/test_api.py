import uuid

from fastapi.testclient import TestClient
from sqlalchemy import delete
from sqlalchemy.orm import Session

from app.entities import User


def test_login(test_client: TestClient, user_in_db: User):
    """
    Testa rota de login.

    Caso 1: 200 - login com sucesso.
    Caso 2: 404 - usuário inválido.
    Caso 2: 404 - senha inválida.
    """

    test_cases: list[dict] = [
        {
            "input": {
                "username": user_in_db.email,
                "password": "Abcd1234#",
            },
            "expected": (200, {"token_type": "bearer"}),
        },
        {
            "input": {"username": "invalid_email@teste.io", "password": "1234"},
            "expected": (
                403,
                {"error_code": 1, "message": "Email ou senha inválidos."},
            ),
        },
        {
            "input": {
                "username": user_in_db.email,
                "password": "wrong_password",
            },
            "expected": (
                403,
                {"error_code": 1, "message": "Email ou senha inválidos."},
            ),
        },
    ]
    for test_case in test_cases:
        response = test_client.post("/users/login", data=test_case["input"])
        response_json = response.json()
        expected_status_code, expected_json = test_case["expected"]
        assert response.status_code == expected_status_code
        for key, value in expected_json.items():
            assert response_json[key] == value


def test_post_new_user(test_client: TestClient, database: Session):
    """
    Testa rota de cadastro de usuários.

    Caso 1: 201 - cadastro com sucesso, sem imagem.
    Caso 2: 201 - cadastro com sucesso, com imagem.
    Caso 3: 400 - Email já cadastrado.
    """

    test_cases = [
        {
            "input": {
                "name": "Usuário Teste da Silva",
                "email": "usuario@teste.io",
                "phone": "912345678",
                "password": "Abcd1234#",
            },
            "expected_out": 201,
        },
        {
            "input": {
                "name": "Usuário Teste da Silva",
                "email": "usuario2@teste.io",
                "phone": "912345678",
                "password": "Abcd1234#",
                "profile_picture": "url_da_imagem",
            },
            "expected_out": 201,
        },
        {
            "input": {
                "name": "Usuário Teste",
                "email": "usuario@teste.io",
                "phone": "912345678",
                "password": "Abcd1234#",
            },
            "expected_out": 400,
        },
    ]

    try:
        for test_case in test_cases:
            response = test_client.post("users/new", json=test_case["input"])
            assert response.status_code == test_case["expected_out"]
    finally:
        database.execute(delete(User))
        database.commit()


def test_get_user(test_client: TestClient, user_in_db: User):
    """
    Testa rota de consulta de usuários.

    Caso 1: 200 - retornado com sucesso.
    Caso 2: 404 - não encontrado.
    """

    test_cases = [
        {
            "input": user_in_db.id,
            "expected_out": (
                200,
                {
                    "id": str(user_in_db.id),
                    "name": "Usuário Teste da Silva",
                    "email": "usuario@teste.io",
                    "phone": "912345678",
                    "profile_picture": {"content": "url_da_imagem"},
                },
            ),
        },
        {
            "input": uuid.uuid4(),
            "expected_out": (
                404,
                {"error_code": 1, "message": "Usuário não encontrado."},
            ),
        },
    ]
    for test_case in test_cases:
        response = test_client.get(f"users/{test_case['input']}")
        assert (response.status_code, response.json()) == test_case["expected_out"]
