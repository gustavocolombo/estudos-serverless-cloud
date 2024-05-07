resource "null_resource" "install_layer_deps" {
  triggers = {
    layer_build = filemd5("${local.layers_path}/axios/nodejs/package.json")
  }

  provisioner "local-exec" {
    working_dir = "${local.layers_path}/axios/nodejs"
    command     = "npm install --production"
  }
}

data "archive_file" "layer_deps_artefact" {
  output_path = "files/axios-layer.zip"
  type        = "zip"
  source_dir  = "${local.layers_path}/axios"
  depends_on  = [null_resource.install_layer_deps]
}

resource "aws_lambda_layer_version" "lambda_layer_poke" {
  layer_name          = "lambda_layer_poke"
  description         = "axios: ^1.6.8"
  filename            = data.archive_file.layer_deps_artefact.output_path
  source_code_hash    = data.archive_file.layer_deps_artefact.output_base64sha256
  compatible_runtimes = ["nodejs16.x"]
}