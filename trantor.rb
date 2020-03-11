class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.0.2.tar.gz"
  version "0.0.2"
  sha256 "b9b6f3ff2464bf6b160a95c343c4b92ef07ad02e72ddcd780b58d3d5031507b2"

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
