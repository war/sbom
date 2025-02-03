INSERT INTO sbom_formats (name, description, ordinal) VALUES
    ('SPDX', 'Software Package Data Exchange format', 10),
    ('CycloneDX', 'Lightweight SBOM format focusing on supply chain component tracking', 20),
    ('SWID', 'Software Identification Tags format', 30);

INSERT INTO component_types (name, description, ordinal) VALUES
    ('APPLICATION', 'Complete software application', 10),
    ('FRAMEWORK', 'Software framework or platform', 20),
    ('LIBRARY', 'Software library or package', 30),
    ('CONTAINER', 'Container image or configuration', 40),
    ('OPERATING_SYSTEM', 'Operating system or distribution', 50),
    ('DEVICE', 'Hardware device or component', 60),
    ('FILE', 'Individual file', 70),
    ('FIRMWARE', 'Device firmware or embedded software', 80);

INSERT INTO dependency_types (name, description, ordinal) VALUES
    ('DEPENDS_ON', 'Direct dependency relationship', 10),
    ('CONTAINS', 'Component containment relationship', 20),
    ('REQUIRES', 'Required but not directly dependent', 30),
    ('PROVIDES', 'Component provides functionality', 40),
    ('OPTIONAL', 'Optional dependency', 50);

INSERT INTO vulnerability_severities (name, description, level, ordinal) VALUES
    ('CRITICAL', 'Severe vulnerability requiring immediate attention', 5, 10),
    ('HIGH', 'High-risk vulnerability requiring prompt attention', 4, 20),
    ('MEDIUM', 'Moderate risk vulnerability', 3, 30),
    ('LOW', 'Low risk vulnerability', 2, 40),
    ('NONE', 'No known vulnerability', 1, 50);

INSERT INTO user_roles (name, description, ordinal) VALUES
    ('ADMIN', 'System administrator with full access', 10),
    ('MANAGER', 'Project or organisation manager', 20),
    ('USER', 'Standard user with basic access', 30),
    ('READONLY', 'Read-only access user', 40);

INSERT INTO audit_action_types (name, description, ordinal) VALUES
    ('CREATE', 'Resource creation action', 10),
    ('UPDATE', 'Resource update action', 20),
    ('DELETE', 'Resource deletion action', 30),
    ('VIEW', 'Resource view action', 40),
    ('EXPORT', 'Resource export action', 50),
    ('IMPORT', 'Resource import action', 60);

