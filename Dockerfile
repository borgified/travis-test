FROM microsoft/windowsservercore:1803

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# From https://github.com/StefanScherer/dockerfiles-windows/blob/master/chocolatey/Dockerfile
ENV chocolateyUseWindowsCompression false
RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress
# Install a CLI text editor
RUN choco install micro -y

RUN choco install firefox -y
