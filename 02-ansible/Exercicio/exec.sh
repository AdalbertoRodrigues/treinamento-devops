terraform init
terraform apply -auto-approve
sleep 10
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i hosts exercicio.yaml -u ubuntu --private-key ~/key.pem
