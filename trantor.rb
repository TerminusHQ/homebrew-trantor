class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.17.9.tar.gz"
  version "0.17.9"
  sha256 "d83350c66cc47666f0168c569cbd16a20511d78bf2f4422aec56bc1fb2564acc"

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
      export TRANTOR_CLI_VERSION="0.17.9"
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