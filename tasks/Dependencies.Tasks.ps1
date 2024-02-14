task InstallBuildDependencies {
    Install-Module PsMermaidTools, platyPs, powershell-yaml
}

task InstallTestDependencies {
    Install-Module PsMermaidTools
}

task InstallReleaseDependencies {
    Install-Module PsMermaidTools
}