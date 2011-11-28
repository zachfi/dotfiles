# AWS related paths and environment variables

if [ -d $HOME/aws ]; then
  # So AWS and EC2 stuff can find the right java
  export JAVA_HOME='/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home'
  export AWS_IAM_HOME="$HOME/aws/IAMCli-1.2.0"
  export AWS_CLOUDFORMATION_HOME="${HOME}/aws/AWSCloudFormation-1.0.9"
  export AWS_CREDENTIAL_FILE="$HOME/.aws/security"
  [[ -d ${AWS_IAM_HOME}/bin ]]            && PATH="$PATH:$AWS_IAM_HOME/bin"
  [[ -d ${AWS_CLOUTFORMATION_HOME}/bin ]] && PATH="$PATH:$AWS_CLOUDFORMATION_HOME/bin"
fi

