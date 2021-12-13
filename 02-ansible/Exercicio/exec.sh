terraform init
terraform apply -auto-approve
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i hosts exercicio.yaml -u ubuntu --private-key ~/key.pem
