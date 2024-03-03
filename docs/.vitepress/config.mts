import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "NexNS",
  description: "NexNS Docs",
  themeConfig: {

    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Examples', link: '/markdown-examples' }
    ],

    sidebar: [
      {
        text: 'Examples',
        items: [
          { text: 'Markdown Examples', link: '/markdown-examples' },
          { text: 'Runtime API Examples', link: '/api-examples' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/JourneyBean/NexNS/tree/main/docs' }
    ]
  },
  locales: {
    en: {
      label: 'English',
      lang: 'en'
    },
    zh: {
      label: '中文',
      lang: 'zh',
      themeConfig: {

        nav: [
          { text: '主页', link: '/zh/' },
        ],
    
        sidebar: [
          {
            text: '关于 NexNS',
            link: '/zh/about/',
            items: [
              { text: '架构设计', link: '/zh/about/architecture'},
              { text: '参与贡献', link: '/zh/about/contributing'},
            ]
          },
          {
            text: '部署和配置',
            link: '/zh/deploy/',
            items: [
              {
                text: '控制器',
                link: '/zh/deploy/controller/deploy',
                items: [
                  { text: '部署', link: '/zh/deploy/controller/deploy'},
                  {
                    text: '配置',
                    link: '/zh/deploy/controller/config/backend',
                    items: [
                      { text: '服务配置', link: '/zh/deploy/controller/config/backend'},
                      { text: 'Web 服务配置', link: '/zh/deploy/controller/config/webserver'},
                    ]
                  },
                ]
              },
              
              { text: '服务端', link: '/zh/deploy/server'},
            ]
          },
          {
            text: '控制器使用指南',
            link: '/zh/controller/',
            items: [
              { text: '创建域名', link: '/zh/controller/domain' },
              { text: '创建区域', link: '/zh/controller/zone' },
              { text: '创建记录', link: '/zh/controller/record' },
              { text: '变量标记', link: '/zh/controller/variable' },
              { text: '保存和发布', link: '/zh/controller/publish' },
              { text: 'API', link: '/zh/controller/api' },
            ]
          },
          {
            text: '客户端',
            link: '/zh/client/',
            items: [
              { text: 'DDNS', link: '/zh/client/ddns' },
              { text: 'certbot', link: '/zh/client/certbot' },
            ]
          },
        ],
    
        socialLinks: [
          { icon: 'github', link: 'https://github.com/JourneyBean/NexNS/tree/main/docs/zh/' }
        ]
      },
    }
  }
})
