docker build -t osuse:leap .

docker run -i -t -v `pwd`:/build/ osuse:leap
