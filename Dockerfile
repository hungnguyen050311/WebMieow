# Dùng .NET SDK để build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy solution file và project
COPY WebMieow.sln ./
COPY WebMieow/ ./WebMieow/

# Restore và publish
WORKDIR /app/WebMieow
RUN dotnet restore
RUN dotnet publish -c Release -o /app/out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "WebMieow.dll"]
