# 🏗️ AWS Terraform VPC Infrastructure

Este repositório provisiona uma infraestrutura completa na AWS utilizando Terraform, com foco em separação de rede pública e privada, instâncias EC2, NAT Gateway e segurança via Security Groups modulares.

---

## 📦 Recursos Criados

- ✅ VPC customizada com CIDR definido
- ✅ Sub-redes públicas e privadas em múltiplas zonas de disponibilidade
- ✅ Internet Gateway (IGW) para saída pública
- ✅ NAT Gateway com IP elástico para saída da rede privada
- ✅ Tabelas de rotas públicas e privadas
- ✅ Security Groups modulares (SSH, HTTP, HTTPS, UDP customizado)
- ✅ EC2 Bastion Host (sub-rede pública)
- ✅ EC2 VPN/Servidor (sub-rede privada)
- ✅ Módulo de criação de Key Pair (opcional)

---

## 📂 Estrutura dos Módulos

```
modules/
├── vpc/
├── subnet/
├── internet-gateway/
├── nat-gateway/
├── route-table/
├── ec2_instance/
├── security_group/
├── ec2_key_pair/
```

---

## 🚀 Como Usar

### 1. Clone o projeto

```bash
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
```

### 2. Configure as variáveis

Edite o arquivo `terraform.tfvars` ou crie um com os valores personalizados:

```hcl
region                      = "us-east-2"
vpc_cidr                    = "10.232.44.0/22"
subnet-cidr-block-public-01  = "10.232.44.128/25"
subnet-cidr-block-public-02  = "10.232.44.0/25"
subnet-cidr-block-private-01 = "10.232.46.0/24"
subnet-cidr-block-private-02 = "10.232.45.0/24"
name-vpc                   = "VPC-DATACOSMO"
name-owner                 = "Breno Kevin Xavier Silva"
environment                = "Development"
my_ip                      = "SEU_IP_COM_/32"
ami_id                     = "ami-xxxxxxxxxxxxxxx"
```

### 3. Inicialize e aplique

```bash
terraform init
terraform apply
```

---

## 🔐 Acesso via SSH (Key Pair)

Se você estiver usando o módulo `ec2_key_pair`, o arquivo `.pem` será salvo no diretório local. Exemplo de uso:

```bash
chmod 400 bastion-key.pem
ssh -i bastion-key.pem ec2-user@<ip-da-instancia>
```

---

## 📌 Requisitos

- Terraform ≥ 1.3
- AWS CLI configurado (`aws configure`)
- Permissões adequadas para criar recursos (IAM, EC2, VPC, RDS...)

---

## 📄 Licença

Este projeto está licenciado sob a licença MIT.
