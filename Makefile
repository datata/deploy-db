
node-install:
	apt-get install nodejs

npm-install:
	apt-get install npm

clone-repository:
	git clone https://github.com/datata/deploy-db

add-users´:
	chmod +x addUsers.sh && ./addUsers.sh
