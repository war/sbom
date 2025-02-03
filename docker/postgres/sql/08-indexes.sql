-- Create indexes for ordering
CREATE INDEX idx_components_sbom_id ON components(sbom_id);
CREATE INDEX idx_components_package_url ON components(package_url);
CREATE INDEX idx_components_name_version ON components(name, version);
CREATE INDEX idx_dependencies_sbom_id ON dependencies(sbom_id);
CREATE INDEX idx_vulnerabilities_component_id ON vulnerabilities(component_id);
CREATE INDEX idx_vulnerabilities_cve_id ON vulnerabilities(cve_id);
CREATE INDEX idx_audit_logs_entity ON audit_logs(entity_type, entity_id);
CREATE INDEX idx_sboms_project_version ON sboms(project_id, version);
CREATE INDEX idx_sbom_formats_ordinal ON sbom_formats(ordinal);
CREATE INDEX idx_component_types_ordinal ON component_types(ordinal);
CREATE INDEX idx_dependency_types_ordinal ON dependency_types(ordinal);
CREATE INDEX idx_vulnerability_severities_ordinal ON vulnerability_severities(ordinal);
CREATE INDEX idx_user_roles_ordinal ON user_roles(ordinal);
CREATE INDEX idx_audit_action_types_ordinal ON audit_action_types(ordinal);

