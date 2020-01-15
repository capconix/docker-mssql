FROM debian:10.2

# Install general OS packages -------------------------------------------------
RUN apt-get update
RUN apt-get install curl -y
RUN apt-get install unixodbc-dev -y


# Install python-related packages from apt ------------------------------------
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y


# Install python-related packages from pip ------------------------------------
RUN pip3 install pyodbc


# Install stuff to talk to MSSQL Servers --------------------------------------

# Install Microsoft Keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Download Debian 10 sources
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Update repository since we updated sources
RUN apt-get update

# Install MSODBC17 driver from Microsoft
RUN ACCEPT_EULA=Y apt-get install msodbcsql17 -y

# Install mssql-tools
RUN ACCEPT_EULA=Y apt-get install mssql-tools -y


# Copy files into image -------------------------------------------------------
COPY . /

# Label container with information --------------------------------------------
LABEL maintainer="CapConiX LLC, Kennesaw GA"

# Default envrionment variables
ENV SQL_SERVER "192.168.50.211"
ENV SQL_USER "test_user"
ENV SQL_PASS "test_password"
ENV SQL_DB "test_database"

# Command to start container up with ------------------------------------------
CMD python3 /my_python.py