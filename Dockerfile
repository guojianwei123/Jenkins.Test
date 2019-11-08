FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["Ron.Blogs.csproj", ""]
RUN dotnet restore "./Ron.Blogs.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "Ron.Blogs.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Ron.Blogs.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Ron.Blogs.dll"]
