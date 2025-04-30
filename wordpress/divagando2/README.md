# WordPress com NFS e Proxy Reverso Nginx (Fedora Server 40)

Este projeto implementa uma instalação do WordPress utilizando armazenamento NFS compartilhado e um proxy reverso Nginx com certificados SSL Let's Encrypt.

## Pré-requisitos

- Servidor Linux com Docker e Docker Compose instalados
- Acesso root/sudo nos servidores
- Firewall configurado para permitir tráfego NFS (portas 111, 2049)
- Domínio configurado para apontar para o servidor

## Configuração

### 1. Configurar NFS Server

Execute no servidor de armazenamento:
```bash
chmod +x nfs-install.sh
sudo ./nfs-install.sh
```

### 2. Configurar NFS Client

Execute em cada servidor que precisar acessar o armazenamento:
```bash
chmod +x edit-fstab.sh
sudo ./edit-fstab.sh
```

### 3. Configurar Variáveis de Ambiente

Edite o arquivo `env.txt` conforme necessário:
```
DOMAIN=seu-dominio.com.br
VOLUME_PATH=/mnt/nfs/docker-stor
TIMEZONE=America/Sao_Paulo
```
Depois salve como **.env** na mesma pasta docker dos compose.yml

### 4. Iniciar Proxy Reverso

```bash
docker compose -f reverse-proxy_nginx-compose.yml up -d
```

### 5. Iniciar WordPress

```bash
docker compose -f wordpress-compose.yml up -d
```

## Acesso

- WordPress: `https://wordpress.seu-dominio.com.br`
- Painel administrativo: `https://wordpress.seu-dominio.com.br/wp-admin`

## Estrutura de Arquivos

- `nfs-install.sh`: Script para configurar servidor NFS
- `edit-fstab.sh`: Script para configurar clientes NFS
- `env.txt`: Variáveis de ambiente compartilhadas
- `reverse-proxy_nginx-compose.yml`: Configuração do proxy reverso
- `wordpress-compose.yml`: Configuração do WordPress e MySQL

## Considerações de Segurança

1. **Credenciais**: Alterar as senhas padrão no arquivo `wordpress-compose.yml`
2. **NFS**: Restringir acesso ao NFS apenas para IPs necessários
3. **Backups**: Implementar rotina de backups para:
   - Volumes Docker
   - Banco de dados MySQL
   - Certificados SSL

## Comandos Úteis

- Verificar montagem NFS: `df -h` ou `mount | grep nfs`
- Verificar containers: `docker ps`
- Verificar logs: `docker logs <container_name>`
- Reiniciar serviços: `docker compose -f <arquivo> restart`
