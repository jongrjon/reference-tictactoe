#CReating a seciruty group and defining protocols for it opening ports 22 and 80

Usergroup=$(aws ec2 create-security-group --group-name prodenv --description "security group for TicTacToe Production enviroment")
aws ec2 authorize-security-group-ingress --group-name prodenv --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name prodenv --protocol tcp --port 80 --cidr 0.0.0.0/0


#Creating a Key-Pair and setting its user access
aws ec2 create-key-pair --key-name prodenvkey --query 'KeyMaterial' --output text > prodenvkey.pem
chmod 400 prodenvkey.pem

#Creating an instance of EC2
InstanceID=$(aws ec2 run-instances --image-id ami-29ebb519 --security-group-ids "$Usergroup" --count 1 --instance-type t2.micro --key-name prodenvkey --query 'Instances[0].InstanceId')
echo "$InstanceID"

#Fetching the public IP adress to the new machine and connecting to it
PublicIP=$(aws ec2 describe-instances --instance-ids "$InstanceID" --query 'Reservations[0].Instances[0].PublicIpAddress')
ConnectURL=$(echo "$PublicIP"|tr '\.' '\-')