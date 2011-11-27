# So AWS and EC2 stuff can find the right java
export JAVA_HOME='/System/Library/Frameworks/JavaVM.framework/Home'

# EC2 related paths and environment variables
if [ -d $HOME/aws ]; then
  #export EC2_HOME="$HOME/aws"
  export AWS_IAM_HOME="$HOME/aws/IAMCli-1.2.0"
  export AWS_CREDENTIAL_FILE="$HOME/.aws/security"
  [[ -d $AWS_IAM_HOME/bin ]] && PATH="$PATH:$AWS_IAM_HOME/bin"
fi

