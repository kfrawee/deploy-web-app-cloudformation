echo "Updating stack: $1";

aws cloudformation update-stack \
    --stack-name $1 \
    --template-body file://$2 \
    --parameters file://$3 \
    --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
    --profile udacity1