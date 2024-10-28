CREATE TABLE Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(255) NOT NULL,
    tax_rate DECIMAL(5, 2) DEFAULT 12.00
);

INSERT INTO Products (product_id, product_name) VALUES
(1, 'Product A'),
(2, 'Product B'),
(3, 'Product C');

CREATE TABLE Titles (
    title_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    type NVARCHAR(50),
    price DECIMAL(10, 2),
    sales INT,
    royalty DECIMAL(5, 2),
    pub_id INT NOT NULL,
    publication_date DATE,
    FOREIGN KEY (pub_id) REFERENCES Publishers(pub_id) -- This will link to the Publishers table
);

INSERT INTO Titles (title_id, title, type, price, sales, royalty, pub_id, publication_date) VALUES
(1, 'Success in Business', 'Business', 20.00, 6000, 15.00, 0736, '1997-05-12'),
(2, 'Psychology of Mind', 'Psychology', 18.00, 4500, 18.00, 0736, '2000-06-18'),
(3, 'The Art of Life', 'Self-Help', 25.00, 5200, 10.00, 0877, '2003-04-15');


CREATE TABLE Authors (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    city NVARCHAR(100),
    state NVARCHAR(100)
);

INSERT INTO Authors (author_id, first_name, last_name, city, state) VALUES
(1, 'Sarah', 'Johnson', 'Menlo Park', 'CA'),
(2, 'Dean', 'Williams', 'New York', 'NY'),
(3, 'Susan', 'Black', 'Menlo Park', 'CA');

CREATE TABLE Publishers (
    pub_id INT IDENTITY(1,1) PRIMARY KEY,
    pub_name NVARCHAR(255) NOT NULL,
    city NVARCHAR(100),
    country NVARCHAR(50)
);

INSERT INTO Publishers (pub_id, pub_name, city, country) VALUES
(0736, 'Pearson', 'San Francisco', 'USA'),
(0877, 'McGraw Hill', 'New York', 'USA');

CREATE TABLE Title_Author (
    title_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (title_id, author_id),
    FOREIGN KEY (title_id) REFERENCES Titles(title_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

INSERT INTO Title_Author (title_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 3);
