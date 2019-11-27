start:
	minikube start --memory 8000 --cpus 2

clean:
	minikube stop; minikube delete; sudo rm -rf ~/.minikube; sudo rm -rf ~/.kub

ssh:
	minikube ssh

sync:
	rsync -av -e "ssh -i ~/.minikube/machines/minikube/id_rsa" --progress * -t "docker@`minikube ip`:~"