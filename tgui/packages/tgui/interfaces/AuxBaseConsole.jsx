import { Button, NoticeBox, Section, Table, Tabs } from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { ShuttleConsoleContent } from './ShuttleConsole';

export const AuxBaseConsole = (props) => {
  const { data } = useBackend();
  const [tab, setTab] = useSharedState('tab', 1);
  const { type, blind_drop, turrets = [] } = data;
  return (
    <Window
      width={turrets.length ? 620 : 350}
      height={turrets.length ? 310 : 260}
    >
      <Window.Content scrollable={!!turrets.length}>
        <Tabs>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 1}
            onClick={() => setTab(1)}
          >
            {type === 'shuttle' ? 'Shuttle Launch' : 'Base Launch'}
          </Tabs.Tab>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 2}
            onClick={() => setTab(2)}
          >
            Turrets ({turrets.length})
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <ShuttleConsoleContent type={type} blind_drop={blind_drop} />
        )}
        {tab === 2 && <AuxBaseConsoleContent />}
      </Window.Content>
    </Window>
  );
};

const STATUS_COLOR_KEYS = {
  ERROR: 'bad',
  Disabled: 'bad',
  Firing: 'average',
  'All Clear': 'good',
};

export const AuxBaseConsoleContent = (props) => {
  const { act, data } = useBackend();
  const { turrets = [] } = data;
  return (
    <Section
      title={'Turret Control'}
      buttons={
        !!turrets.length && (
          <Button
            icon="power-off"
            content={'Toggle Power'}
            onClick={() => act('turrets_power')}
          />
        )
      }
    >
      {!turrets.length ? (
        <NoticeBox>No connected turrets</NoticeBox>
      ) : (
        <Table cellpadding="3" textAlign="center">
          <Table.Row header>
            <Table.Cell>Unit</Table.Cell>
            <Table.Cell>Condition</Table.Cell>
            <Table.Cell>Status</Table.Cell>
            <Table.Cell>Direction</Table.Cell>
            <Table.Cell>Distance</Table.Cell>
            <Table.Cell>Power</Table.Cell>
          </Table.Row>
          {turrets.map((turret) => (
            <Table.Row key={turret.key}>
              <Table.Cell bold>{turret.name}</Table.Cell>
              <Table.Cell>{turret.integrity}%</Table.Cell>
              <Table.Cell color={STATUS_COLOR_KEYS[turret.status] || 'bad'}>
                {turret.status}
              </Table.Cell>
              <Table.Cell>{turret.direction}</Table.Cell>
              <Table.Cell>{turret.distance}m</Table.Cell>
              <Table.Cell>
                <Button
                  icon="power-off"
                  content="Toggle"
                  onClick={() =>
                    act('single_turret_power', {
                      single_turret_power: turret.ref,
                    })
                  }
                />
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
};
