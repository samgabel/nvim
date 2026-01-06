return {
    settings = {
        yaml = {
            schemas = {
                kubernetes = { "k-*.yaml" },
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*compose.{yml,yaml}",
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",

                -- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                -- ["http://json.schemastore.org/ansible-stable-2.16"] = "roles/tasks/*.{yml,yaml}",
                -- ["https://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                -- ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                -- ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                -- ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
            },

        },
        validate = true,
    },
}
