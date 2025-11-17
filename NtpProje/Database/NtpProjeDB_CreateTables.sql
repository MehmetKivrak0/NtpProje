-- NtpProje Database Table Creation Queries

-- 1. USERS TABLE
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone_number NVARCHAR(20),
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(50) DEFAULT 'User',
    bio NVARCHAR(MAX),
    is_active BIT DEFAULT 1,
    created_date DATETIME DEFAULT GETDATE(),
    last_login_date DATETIME
);

-- 2. CATEGORIES TABLE
CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100) NOT NULL,
    slug NVARCHAR(100) UNIQUE,
    description NVARCHAR(500),
    is_active BIT DEFAULT 1,
    display_order INT DEFAULT 0
);

-- 3. POSTS TABLE (Blog Posts)
CREATE TABLE posts (
    post_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    slug NVARCHAR(250),
    content NVARCHAR(MAX),
    summary NVARCHAR(1000),
    image_url NVARCHAR(500),
    publish_date DATETIME NOT NULL,
    created_date DATETIME DEFAULT GETDATE(),
    updated_date DATETIME,
    status NVARCHAR(50) DEFAULT 'Draft',
    view_count INT DEFAULT 0,
    reading_time INT,
    user_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. POST CATEGORIES RELATION TABLE
CREATE TABLE post_categories (
    post_category_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE,
    UNIQUE(post_id, category_id)
);

-- 5. COMMENTS TABLE
CREATE TABLE comments (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    author_name NVARCHAR(100) NOT NULL,
    author_email NVARCHAR(100),
    content NVARCHAR(MAX) NOT NULL,
    comment_date DATETIME DEFAULT GETDATE(),
    is_approved BIT DEFAULT 0,
    post_id INT NOT NULL,
    user_id INT,
    parent_comment_id INT,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (parent_comment_id) REFERENCES comments(comment_id)
);

-- 6. PROJECTS TABLE
CREATE TABLE projects (
    project_id INT IDENTITY(1,1) PRIMARY KEY,
    project_name NVARCHAR(200) NOT NULL,
    slug NVARCHAR(250),
    description NVARCHAR(MAX),
    short_description NVARCHAR(500),
    image_url NVARCHAR(500),
    thumbnail_url NVARCHAR(500),
    project_date DATETIME NOT NULL,
    completion_date DATETIME,
    client_name NVARCHAR(100),
    category NVARCHAR(100),
    status NVARCHAR(50) DEFAULT 'Active',
    is_published BIT DEFAULT 1,
    display_order INT DEFAULT 0,
    view_count INT DEFAULT 0,
    created_date DATETIME DEFAULT GETDATE(),
    updated_date DATETIME
);

-- 7. PROJECT TECHNOLOGIES TABLE
CREATE TABLE project_technologies (
    project_technology_id INT IDENTITY(1,1) PRIMARY KEY,
    project_id INT NOT NULL,
    technology_name NVARCHAR(100) NOT NULL,
    display_order INT DEFAULT 0,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);

-- 8. PROJECT IMAGES TABLE
CREATE TABLE project_images (
    project_image_id INT IDENTITY(1,1) PRIMARY KEY,
    project_id INT NOT NULL,
    image_url NVARCHAR(500) NOT NULL,
    thumbnail_url NVARCHAR(500),
    title NVARCHAR(200),
    display_order INT DEFAULT 0,
    is_main BIT DEFAULT 0,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);

-- 9. SERVICES TABLE
CREATE TABLE services (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    service_name NVARCHAR(100) NOT NULL,
    slug NVARCHAR(100) UNIQUE,
    description NVARCHAR(MAX),
    short_description NVARCHAR(500),
    icon NVARCHAR(50),
    icon_class NVARCHAR(50),
    image_url NVARCHAR(500),
    is_active BIT DEFAULT 1,
    display_order INT DEFAULT 0,
    view_count INT DEFAULT 0,
    created_date DATETIME DEFAULT GETDATE(),
    updated_date DATETIME
);

-- 10. SERVICE FEATURES TABLE
CREATE TABLE service_features (
    service_feature_id INT IDENTITY(1,1) PRIMARY KEY,
    service_id INT NOT NULL,
    feature_name NVARCHAR(200) NOT NULL,
    display_order INT DEFAULT 0,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

-- 11. TEAM MEMBERS TABLE
CREATE TABLE team_members (
    team_member_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    title NVARCHAR(100),
    position NVARCHAR(100),
    image_url NVARCHAR(500),
    bio NVARCHAR(MAX),
    email NVARCHAR(100),
    phone_number NVARCHAR(20),
    linkedin_url NVARCHAR(500),
    twitter_url NVARCHAR(500),
    github_url NVARCHAR(500),
    is_active BIT DEFAULT 1,
    display_order INT DEFAULT 0,
    created_date DATETIME DEFAULT GETDATE(),
    updated_date DATETIME
);

-- 12. CONTACT MESSAGES TABLE
CREATE TABLE contact_messages (
    contact_message_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    phone_number NVARCHAR(20),
    subject NVARCHAR(100),
    message NVARCHAR(MAX) NOT NULL,
    is_read BIT DEFAULT 0,
    is_replied BIT DEFAULT 0,
    reply_message NVARCHAR(MAX),
    reply_date DATETIME,
    created_date DATETIME DEFAULT GETDATE(),
    ip_address NVARCHAR(50)
);

-- 13. PROJECT REQUESTS TABLE
CREATE TABLE project_requests (
    project_request_id INT IDENTITY(1,1) PRIMARY KEY,
    company_name NVARCHAR(200) NOT NULL,
    contact_person NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,
    project_details NVARCHAR(MAX) NOT NULL,
    budget DECIMAL(18, 2),
    estimated_duration NVARCHAR(100),
    status NVARCHAR(50) DEFAULT 'New',
    is_read BIT DEFAULT 0,
    quoted_price DECIMAL(18, 2),
    quoted_date DATETIME,
    notes NVARCHAR(MAX),
    created_date DATETIME DEFAULT GETDATE(),
    updated_date DATETIME,
    ip_address NVARCHAR(50)
);

-- 14. STATISTICS TABLE
CREATE TABLE statistics (
    statistic_id INT IDENTITY(1,1) PRIMARY KEY,
    statistic_key NVARCHAR(100) NOT NULL UNIQUE,
    statistic_value NVARCHAR(100) NOT NULL,
    statistic_label NVARCHAR(200),
    display_order INT DEFAULT 0,
    is_active BIT DEFAULT 1,
    updated_date DATETIME DEFAULT GETDATE()
);

-- 15. SETTINGS TABLE
CREATE TABLE settings (
    setting_id INT IDENTITY(1,1) PRIMARY KEY,
    setting_key NVARCHAR(100) NOT NULL UNIQUE,
    setting_value NVARCHAR(MAX),
    setting_type NVARCHAR(50),
    description NVARCHAR(500),
    updated_date DATETIME DEFAULT GETDATE()
);
