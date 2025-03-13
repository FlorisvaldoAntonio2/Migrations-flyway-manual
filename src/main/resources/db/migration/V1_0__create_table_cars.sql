CREATE TABLE IF NOT EXISTS cars (
    id SERIAL PRIMARY KEY,                  -- Identificador único (auto-increment)
    make VARCHAR(50) NOT NULL,             -- Marca do carro
    model VARCHAR(50) NOT NULL,            -- Modelo do carro
    year INT CHECK (year >= 1886),         -- Ano de fabricação (mínimo 1886, quando o primeiro carro foi inventado)
    price DECIMAL(10, 2) NOT NULL,         -- Preço do carro
    color VARCHAR(20),                     -- Cor do carro
    created_at TIMESTAMP DEFAULT NOW(),    -- Data de criação do registro
    updated_at TIMESTAMP DEFAULT NOW()     -- Data de atualização do registro
);