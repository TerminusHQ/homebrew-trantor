class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.10.0.tar.gz"
  version "0.10.0"
  sha256 "04d34439f04c874f9b6e1dd77fd9321fd4c6ed70f1cde18e2646767875dbe47b"

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
      export TRANTOR_CLI_VERSION="0.10.0"
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
