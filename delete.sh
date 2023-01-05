echo "Deleting stack: $1";

aws cloudformation delete-stack \
    --stack-name $1 \
    --profile udacity1

