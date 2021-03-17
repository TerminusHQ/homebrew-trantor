class Trantor < Formula
  desc "Terminus Trantor CLI"
  homepage "https://www.terminus.io/"
  url "http://mxsl.oss-cn-hangzhou.aliyuncs.com/dist/trantor/trantor.0.16.36.tar.gz"
  version "0.16.36"
  sha256 "f5d530ccef72d5569146bbbdeddd2c6a6db9bef21af795439269e2d036cbad1d"

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
      export TRANTOR_CLI_VERSION="0.16.36"
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