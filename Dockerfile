FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /app

EXPOSE 8080
EXPOSE 8081

WORKDIR /src
COPY ["Web/Aiia.Sample.csproj", "Web/"]
RUN dotnet restore "Web/Aiia.Sample.csproj"
COPY . .
WORKDIR "/src/Web"
RUN dotnet build "Aiia.Sample.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Aiia.Sample.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Aiia.Sample.dll"]