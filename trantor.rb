class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.15.0.tar.gz"
  version "0.15.0"
  sha256 "de50d3c1b33a981d246c8f36e37a7a0849ce4c758f5f0d1144061207a5630b00"

#   depends_on "docker"

  def buildExe()
    <<~EOS
      #!/bin/bash
      if [ -z "$JAVA_HOME" ] ; then
        JAVACMD=`which java`
      else
        JAVACMD="$JAVA_HOME/bin/java"
      fi
      export TRANTOR_HOME="#{prefix}"
      export TRANTOR_CLI_VERSION="0.15.0"
      exec "$JAVACMD" -jar "#{libexec}/trantor-cli.jar" "$@"
    EOS
  end

  def install
    # Remove windows files
    lib.install Dir["lib/*"]
    libexec.install Dir["libexec/*"]
    (bin/"trantor").write buildExe()
  end

  test do
    system "#{bin}/trantor", "version"
  end

end
