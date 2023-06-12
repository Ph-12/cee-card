# Estágio de construção
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "cee-card/cee-card.csproj"
RUN dotnet build "cee-card/cee-card.csproj" -c Release -o /app/build

# Estágio de publicação
FROM build AS publish
RUN dotnet publish "cee-card/cee-card.csproj" -c Release -o /app/publish

# Estágio final
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "cee-card.dll"]