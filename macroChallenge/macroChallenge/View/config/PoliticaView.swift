//
//  PoliticaView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import SwiftUI

struct PoliticaView: View {
    var body: some View {
        ZStack {
            Image("fundoC")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                Text("")
                Text("""
                    BCMR construiu o B.O.M.B. app como [open source/free/freemium/ad-supported/commercial] app. Este SERVIÇO é fornecido pela BCMR sem nenhum custo e deve ser usado como está.
                    Esta página é usada para informar os visitantes sobre nossas políticas de coleta, uso e divulgação de informações pessoais, caso alguém decida usar nosso serviço.
                    Se você optar por usar nosso Serviço, concorda com a coleta e o uso de informações relacionadas a esta política. As informações pessoais que coletamos são usadas para fornecer e melhorar o serviço. Não usaremos ou compartilharemos suas informações com ninguém, exceto conforme descrito nesta Política de Privacidade.
                    Os termos utilizados nesta Política de Privacidade têm os mesmos significados dos nossos Termos e Condições, que podem ser acessados em B.O.M.B. a menos que definido de outra forma nesta Política de Privacidade.
                    
                    Coleta e uso de informações
                    Para uma melhor experiência, ao usar nosso Serviço, podemos exigir que você nos forneça algumas informações de identificação pessoal. As informações que solicitamos serão retidas por nós e usadas conforme descrito nesta política de privacidade.

                    Dados de registro
                    Queremos informar que sempre que você usa nosso Serviço, em caso de erro no aplicativo, coletamos dados e informações (através de produtos de terceiros) em seu telefone chamado Log Data. Esses dados de registro podem incluir informações como endereço de protocolo de Internet ("IP") do dispositivo, nome do dispositivo, versão do sistema operacional, configuração do aplicativo ao utilizar nosso serviço, hora e data de uso do serviço e outras estatísticas.

                    Cookies
                    Cookies são arquivos com uma pequena quantidade de dados que são comumente usados como identificadores únicos anônimos. Estes são enviados para o seu navegador a partir dos sites que você visita e são armazenados na memória interna do seu dispositivo.
                    Este Serviço não usa esses “cookies” explicitamente. No entanto, o aplicativo pode usar código e bibliotecas de terceiros que usam “cookies” para coletar informações e melhorar seus serviços. Você tem a opção de aceitar ou recusar esses cookies e saber quando um cookie está sendo enviado ao seu dispositivo. Se você optar por recusar nossos cookies, talvez não consiga usar algumas partes deste Serviço.
                    
                    Provedores de serviço
                    Podemos empregar empresas e indivíduos terceirizados devido aos seguintes motivos:
                    Para facilitar nosso Serviço;
                    Para fornecer o Serviço em nosso nome;
                    Para realizar serviços relacionados ao Serviço; ou
                    Para nos ajudar a analisar como nosso Serviço é usado.
                    Queremos informar aos usuários deste Serviço que esses terceiros têm acesso às suas Informações Pessoais. O motivo é realizar as tarefas atribuídas a eles em nosso nome. No entanto, eles são obrigados a não divulgar ou usar as informações para qualquer outra finalidade.
                    
                    Segurança
                    Valorizamos sua confiança em nos fornecer suas informações pessoais, portanto, estamos nos esforçando para usar meios comercialmente aceitáveis de protegê-las. Mas lembre-se que nenhum método de transmissão pela internet, ou método de armazenamento eletrônico é 100% seguro e confiável, e não podemos garantir sua segurança absoluta.
                    
                    Links para outros sites
                    Este Serviço pode conter links para outros sites. Se você clicar em um link de terceiros, será direcionado para esse site. Observe que esses sites externos não são operados por nós. Portanto, recomendamos fortemente que você revise a Política de Privacidade desses sites. Não temos controle e não assumimos nenhuma responsabilidade pelo conteúdo, políticas de privacidade ou práticas de sites ou serviços de terceiros.
                    
                    Privacidade das crianças
                    Não coletamos intencionalmente informações de identificação pessoal de crianças. Incentivamos todas as crianças a nunca enviar nenhuma informação de identificação pessoal por meio do Aplicativo e/ou Serviços. Incentivamos os pais e responsáveis legais a monitorar o uso da Internet por seus filhos e a ajudar a aplicar esta Política, instruindo seus filhos a nunca fornecer informações de identificação pessoal por meio do Aplicativo e/ou Serviços sem a permissão deles. Se você tiver motivos para acreditar que uma criança nos forneceu informações de identificação pessoal por meio do Aplicativo e/ou Serviços, entre em contato conosco. Você também deve ter pelo menos 16 anos de idade para consentir com o processamento de suas informações de identificação pessoal em seu país (em alguns países, podemos permitir que seus pais ou responsáveis o façam em seu nome).
                    
                    Mudanças nesta Política de Privacidade
                    Podemos atualizar nossa Política de Privacidade de tempos em tempos. Assim, você é aconselhado a revisar esta página periodicamente para quaisquer alterações. Iremos notificá-lo sobre quaisquer alterações publicando a nova Política de Privacidade nesta página.
                    
                    Esta política é efetiva a partir de 2023-08-02
                    
                    Contate-nos
                    Se você tiver alguma dúvida ou sugestão sobre nossa Política de Privacidade, não hesite em nos contatar em bomb.bcmr@gmail.com.
                    """)
                .multilineTextAlignment(.leading)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 100)
                .foregroundColor(.black)
            }
        }
            .navigationTitle("Política de privacidade")
            .navigationBarTitleDisplayMode(.inline)
    }
}

