# 10 - Debloater Granular

Esta pasta contem scripts para remover aplicativos pre-instalados (bloatware) do Windows de forma granular. A remocao desses aplicativos pode liberar recursos do sistema, melhorar a privacidade e reduzir a quantidade de processos em segundo plano.

## Scripts Disponiveis:

- **01_remover_xbox_apps.bat**: Remove os aplicativos relacionados ao Xbox (Xbox App, Game Bar, Identity Provider, Speech To Text Overlay).
- **02_remover_cortana.bat**: Remove o assistente de voz Cortana do sistema.
- **03_remover_teams.bat**: Remove o aplicativo Microsoft Teams (versao AppX e instalador).
- **04_remover_onedrive.bat**: Desinstala o OneDrive e remove sua integracao com o Explorador de Arquivos.

## Como Usar:

1.  **Execute como Administrador**: Clique com o botao direito no script .bat desejado e selecione "Executar como administrador".
2.  **Siga as Instrucoes**: O script ira exibir mensagens no console informando o progresso da remocao.
3.  **Reinicie (Opcional)**: Apos a remocao, pode ser util reiniciar o sistema para garantir que todas as alteracoes sejam aplicadas.

## Observacoes Importantes:

-   **Crie um Ponto de Restauracao**: Sempre e recomendado criar um ponto de restauracao do sistema antes de executar qualquer script de remocao de bloatware.
-   **Funcionalidade**: A remocao de alguns aplicativos pode afetar funcionalidades relacionadas. Por exemplo, remover o OneDrive desativara a sincronizacao de arquivos na nuvem.
-   **Reinstalacao**: A maioria desses aplicativos pode ser reinstalada pela Microsoft Store, caso voce mude de ideia.
